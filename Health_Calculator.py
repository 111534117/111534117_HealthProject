import customtkinter as ctk
import sqlite3
import tkinter.messagebox as tk_mb
from tkinter import filedialog
from datetime import datetime
import pandas as pd
import matplotlib.pyplot as plt

# --- 1. 運算核心 (維持不變) ---


def calculate_bmi(height, weight):
    bmi = weight / ((height / 100) ** 2)
    if bmi < 18.5:
        status = "體重過輕"
    elif 18.5 <= bmi < 24:
        status = "正常範圍"
    elif 24 <= bmi < 27:
        status = "異常提醒"
    else:
        status = "肥胖警告"
    return round(bmi, 2), status


def get_diet_advice(status):
    advice = {
        "體重過輕": "建議多吃優質蛋白質（肉、蛋、豆），並增加熱量攝取。",
        "正常範圍": "維持均衡飲食，多吃原型食物，繼續保持！",
        "異常提醒": "注意含糖飲料和加工食品，每餐澱粉量可以少吃一點點。",
        "肥胖警告": "建議實施減醣飲食，多吃蔬果和高纖維食物，避開油炸物。"
    }
    return advice.get(status, "建議諮詢專業營養師。")


def calculate_bmr(gender, age, height, weight):
    if gender == "男":
        return int(10 * weight + 6.25 * height - 5 * age + 5)
    else:
        return int(10 * weight + 6.25 * height - 5 * age - 161)

# --- 2. 主視窗介面 (新增修改邏輯) ---


class HealthApp(ctk.CTk):
    def __init__(self):
        super().__init__()
        self.title("健康管理系統 v3.4 - 支援資料修改")
        self.geometry("600x900")  # 稍微拉長一點點放新按鈕
        self.db_name = 'health_history.db'
        self.init_db()

        self.main_frame = ctk.CTkFrame(self)
        self.main_frame.pack(padx=20, pady=20, fill="both", expand=True)

        ctk.CTkLabel(self.main_frame, text="個人健康數據追蹤系統", font=(
            "Microsoft JhengHei", 22, "bold")).grid(row=0, column=0, columnspan=2, pady=20)

        # --- 輸入欄位 ---
        self.entries = {}
        fields = [("使用者名稱:", "username"), ("身高 (cm):", "height"),
                  ("體重 (kg):", "weight"), ("年齡:", "age")]
        for i, (label, key) in enumerate(fields, start=1):
            ctk.CTkLabel(self.main_frame, text=label).grid(
                row=i, column=0, padx=15, pady=8, sticky="w")
            entry = ctk.CTkEntry(self.main_frame, width=250)
            entry.grid(row=i, column=1, padx=15, pady=8, sticky="ew")
            self.entries[key] = entry

        ctk.CTkLabel(self.main_frame, text="性別:").grid(
            row=5, column=0, padx=15, pady=8, sticky="w")
        self.gender_combobox = ctk.CTkComboBox(
            self.main_frame, values=["男", "女"], width=250)
        self.gender_combobox.grid(
            row=5, column=1, padx=15, pady=8, sticky="ew")

        # --- 新增：修改專用的編號輸入框 ---
        ctk.CTkLabel(self.main_frame, text="要修改的紀錄 ID:", text_color="#FFD700").grid(
            row=6, column=0, padx=15, pady=8, sticky="w")
        self.modify_id_entry = ctk.CTkEntry(
            self.main_frame, width=250, placeholder_text="只有『修改』時需要填寫")
        self.modify_id_entry.grid(
            row=6, column=1, padx=15, pady=8, sticky="ew")

        # --- 按鈕區 ---
        ctk.CTkButton(self.main_frame, text="儲存新紀錄", command=self.save_record).grid(
            row=7, column=0, padx=10, pady=15)
        # 修改按鈕用亮眼的藍色
        ctk.CTkButton(self.main_frame, text="修改指定紀錄", fg_color="#3B8ED0",
                      command=self.update_record).grid(row=7, column=1, padx=10, pady=15)

        ctk.CTkButton(self.main_frame, text="查看體重趨勢", fg_color="#2CC985",
                      command=self.show_trend_chart).grid(row=8, column=0, padx=10, pady=15)
        ctk.CTkButton(self.main_frame, text="清空輸入框", fg_color="gray",
                      command=self.clear_fields).grid(row=8, column=1, padx=10, pady=15)

        # --- 預覽區 ---
        ctk.CTkLabel(self.main_frame, text="--- 最近紀錄預覽 (含 ID 編號) ---", font=(
            "Microsoft JhengHei", 12)).grid(row=9, column=0, columnspan=2, pady=(10, 0))
        self.history_box = ctk.CTkTextbox(
            self.main_frame, height=200, font=("Consolas", 11))
        self.history_box.grid(row=10, column=0, columnspan=2,
                              padx=15, pady=10, sticky="nsew")

        ctk.CTkButton(self.main_frame, text="匯出報表 (CSV)", fg_color="#FF9500", command=self.export_to_csv).grid(
            row=11, column=0, columnspan=2, padx=10, pady=10)

        self.refresh_history()

    def init_db(self):
        conn = sqlite3.connect(self.db_name)
        conn.execute("CREATE TABLE IF NOT EXISTS records (record_id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, 儲存時間 TEXT, 身高 REAL, 體重 REAL, 年齡 INTEGER, 性別 TEXT, BMI REAL, 體重狀態 TEXT, BMR INTEGER)")
        conn.close()

    def refresh_history(self):
        """更新預覽，這次要把 ID 顯示出來"""
        self.history_box.configure(state="normal")
        self.history_box.delete("0.0", "end")
        try:
            conn = sqlite3.connect(self.db_name)
            # 多抓一個 record_id 欄位
            df = pd.read_sql_query(
                "SELECT record_id, username, BMI, 體重狀態 FROM records ORDER BY record_id DESC LIMIT 5", conn)
            conn.close()
            if not df.empty:
                header = f"{'ID':<4} {'姓名':<6} {'BMI':<7} {'狀態'}\n"
                self.history_box.insert("end", header + "-" * 40 + "\n")
                for _, r in df.iterrows():
                    self.history_box.insert(
                        "end", f"{r['record_id']:<4} {r['username']:<6} {r['BMI']:<7.2f} {r['體重狀態']}\n")
        except:
            pass
        self.history_box.configure(state="disabled")

    def save_record(self):
        """儲存新資料的邏輯 (維持不變)"""
        try:
            u, h, w, a, g = self.get_inputs()
            bmi_v, bmi_s = calculate_bmi(h, w)
            bmr_v = calculate_bmr(g, a, h, w)
            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            conn = sqlite3.connect(self.db_name)
            conn.execute("INSERT INTO records (username, 儲存時間, 身高, 體重, 年齡, 性別, BMI, 體重狀態, BMR) VALUES (?,?,?,?,?,?,?,?,?)",
                         (u, now, h, w, a, g, bmi_v, bmi_s, bmr_v))
            conn.commit()
            conn.close()
            self.refresh_history()
            tk_mb.showinfo(
                "成功", f"紀錄已儲存！\nBMI: {bmi_v}\n建議: {get_diet_advice(bmi_s)}")
        except ValueError:
            tk_mb.showerror("錯誤", "請檢查數字格式是否正確")

    # --- 新增：修改紀錄的函式 ---
    def update_record(self):
        """根據輸入的 ID 修改對應的資料內容"""
        target_id = self.modify_id_entry.get()
        if not target_id:
            tk_mb.showwarning("提示", "請先輸入要修改的『紀錄 ID』")
            return

        try:
            u, h, w, a, g = self.get_inputs()
            bmi_v, bmi_s = calculate_bmi(h, w)
            bmr_v = calculate_bmr(g, a, h, w)
            now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

            conn = sqlite3.connect(self.db_name)
            # 使用 SQL 的 UPDATE 指令
            cursor = conn.execute("""
                UPDATE records 
                SET username=?, 儲存時間=?, 身高=?, 體重=?, 年齡=?, 性別=?, BMI=?, 體重狀態=?, BMR=?
                WHERE record_id=?
            """, (u, now, h, w, a, g, bmi_v, bmi_s, bmr_v, target_id))

            if cursor.rowcount == 0:
                tk_mb.showerror("失敗", f"找不到 ID 為 {target_id} 的紀錄")
            else:
                conn.commit()
                tk_mb.showinfo("修改成功", f"編號 {target_id} 的紀錄已更新！")

            conn.close()
            self.refresh_history()
        except ValueError:
            tk_mb.showerror("錯誤", "請確保資料格式正確")

    def get_inputs(self):
        """小工具：一次抓取所有格子的值"""
        return (
            self.entries['username'].get(),
            float(self.entries['height'].get()),
            float(self.entries['weight'].get()),
            int(self.entries['age'].get()),
            self.gender_combobox.get()
        )

    def show_trend_chart(self):
        name = self.entries['username'].get()
        conn = sqlite3.connect(self.db_name)
        df = pd.read_sql_query(
            "SELECT * FROM records WHERE username=? ORDER BY record_id ASC", conn, params=(name,))
        conn.close()
        if df.empty:
            return
        plt.rcParams['font.sans-serif'] = ['Microsoft JhengHei']
        plt.plot(df['儲存時間'].str[5:16], df['體重'], marker='o', color='green')
        plt.title(f"{name} 的體重趨勢")
        plt.show()

    def export_to_csv(self):
        conn = sqlite3.connect(self.db_name)
        df = pd.read_sql_query("SELECT * FROM records", conn)
        conn.close()
        path = filedialog.asksaveasfilename(defaultextension=".csv")
        if path:
            df.to_csv(path, index=False, encoding='utf-8-sig')
            tk_mb.showinfo("成功", "報表已匯出")

    def clear_fields(self):
        for e in self.entries.values():
            e.delete(0, 'end')
        self.modify_id_entry.delete(0, 'end')


if __name__ == "__main__":
    app = HealthApp()
    app.mainloop()
