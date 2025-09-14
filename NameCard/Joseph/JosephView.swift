//  NameCard
//
//  Created by Joseph-M2 on 2025/9/9.
//

import SwiftUI

// 主視圖，用來呈現整張名片
struct JosephView: View {
    
    // MARK: - 屬性 (Properties)
    
    // 定義顏色以便重複使用，讓程式碼更乾淨
    let cardBackgroundColor = Color(red: 0.16, green: 0.18, blue: 0.21)
    let jsonKeyColor = Color(red: 0.98, green: 0.45, blue: 0.49)
    let jsonValueColor = Color(red: 0.9, green: 0.75, blue: 0.48)
    let defaultTextColor = Color.white.opacity(0.9)
    let secondaryTextColor = Color.gray
    let macRed = Color(red: 1.0, green: 0.37, blue: 0.34)
    let macYellow = Color(red: 1.0, green: 0.74, blue: 0.22)
    let macGreen = Color(red: 0.19, green: 0.8, blue: 0.43)

    // MARK: - 視圖主體 (Body)
    
    var body: some View {
        ZStack {
            // 背景，模擬原始圖片中的暖色調背景
            Color(red: 0.85, green: 0.78, blue: 0.7)
                .ignoresSafeArea()

            // 名片主體
            VStack(alignment: .leading, spacing: 0) {
                // 1. 標題列 (Title Bar)
                titleBar
                
                // 2. 工具列 (Toolbar)
                toolBar
                
                // 分隔線
                Divider()
                    .background(Color.gray.opacity(0.3))
                    .padding(.horizontal)

                // 3. 程式碼編輯區 (Code Area)
                codeArea
                    .padding()
            }
            .background(cardBackgroundColor)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.4), radius: 20, x: 0, y: 10)
            .padding(30) // 讓名片與螢幕邊緣有些間距
        }
    }
    
    // MARK: - 子視圖 (Subviews)

    /// 標題列，包含 macOS 風格的紅綠燈按鈕和檔案名稱
    private var titleBar: some View {
        HStack {
            // 左側紅綠燈按鈕
            HStack(spacing: 8) {
                Circle().fill(macRed)
                Circle().fill(macYellow)
                Circle().fill(macGreen)
            }
            .frame(width: 60)
            .padding(.leading)
            
            Spacer()
            
            // 中間檔案標題
            Text("Name Card.json")
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundStyle(secondaryTextColor)
            
            Spacer()

            // 右側漢堡選單圖示
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(secondaryTextColor)
                .frame(width: 60)
        }
        .frame(height: 40)
    }
    
    /// 工具列，顯示各種編輯器圖示
    private var toolBar: some View {
        HStack(spacing: 18) {
            Image(systemName: "arrow.uturn.backward")
            Image(systemName: "doc.text")
            Image(systemName: "curlybraces")
            
            HStack(spacing: 12) {
                Image(systemName: "arrow.left")
                Image(systemName: "arrow.right")
                Rectangle()
                    .fill(secondaryTextColor)
                    .frame(width: 1, height: 16)
            }

            Spacer()

            Image(systemName: "square")
            Image(systemName: "ellipsis")
        }
        .font(.system(size: 14))
        .foregroundStyle(secondaryTextColor)
        .padding(.horizontal)
        .padding(.bottom, 8)
    }

    /// 程式碼編輯區，包含行號和 JSON 內容
    private var codeArea: some View {
        HStack(alignment: .top, spacing: 10) {
            // 左側行號
            VStack(alignment: .trailing, spacing: 4) {
                Text("1")
                Text("2")
                Text("3")
                Text("4")
                Text("5")
                Text("6")
                Text("7")
            }
            .font(.system(size: 16, design: .monospaced))
            .foregroundStyle(secondaryTextColor)
            
            // 右側 JSON 程式碼
            VStack(alignment: .leading, spacing: 4) {
                Text("{")
                
                // 使用 `+` 運算子組合不同顏色的 Text
                Text("  \"name\": ")
                    .foregroundStyle(jsonKeyColor)
                + Text("\"Joseph Tao\",")
                    .foregroundStyle(jsonValueColor)
                
                // 處理 title 的多行顯示
                HStack(alignment: .top, spacing: 0) {
                    Text("  \"title\": ")
                        .foregroundStyle(jsonKeyColor)
                    
                    HStack(alignment: .top, spacing: -30) {
                        Text("Captain Mars Vessel ")
                        Text("of the ")
                    }
                    .foregroundStyle(jsonValueColor)
                }
                
                HStack(alignment: .top, spacing: 0) {
                    Text("  \"linkedin\": ")
                        .foregroundStyle(jsonKeyColor)
                    
                    HStack(alignment: .top, spacing: -10) {
                        Text("linkedin in/jzzt")
                        Text(".com/")
                    }
                        .foregroundStyle(jsonValueColor)
                }
                Text("}")
            }
            .font(.system(size: 16, weight: .medium, design: .monospaced))
            .foregroundStyle(defaultTextColor)
            // 使用 .leading 對齊，確保程式碼靠左
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


// MARK: - 預覽 (Preview)
#Preview {
    JosephView()
}
