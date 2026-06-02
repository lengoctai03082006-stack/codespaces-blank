<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>GREEN ECO-MARKET - Công Cụ Đa Tiện Ích Chuyển Đổi</title>
    <style>
        body { 
            font-family: Arial, Helvetica, sans-serif; 
            margin: 0; padding: 0 0 50px 0; background-color: #f1f3f7; color: #333333;
            display: flex; flex-direction: column; align-items: center;
        }
        /* Layout chia 2 form nằm cạnh nhau cân bằng */
        .container { 
            width: 100%; max-width: 1100px; margin-top: 40px; padding: 0 20px; 
            box-sizing: border-box; display: flex; gap: 30px;
        }
        
        .content-card {
            flex: 1; background: #ffffff; border-radius: 16px; padding: 35px 40px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05); display: flex; flex-direction: column;
        }
        
        .content-card h2 {
            font-size: 20px; color: #128c46; margin-top: 0; margin-bottom: 25px;
            font-weight: bold; text-align: center; border-bottom: 2px solid #f1f3f7; padding-bottom: 12px;
        }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 14px; font-weight: bold; margin-bottom: 8px; color: #555555; }
        .form-input { width: 100%; padding: 12px 14px; border: 1px solid #cccccc; border-radius: 6px; font-size: 15px; outline: none; box-sizing: border-box; color: #333333; }
        .form-input:focus { border-color: #128c46; }
        
        .btn-submit { width: 100%; background-color: #128c46; color: white; border: none; padding: 12px; font-size: 15px; border-radius: 6px; cursor: pointer; font-weight: bold; transition: background 0.2s; }
        .btn-submit:hover { background-color: #0e6f37; }
        
        .result-box { margin-top: auto; padding: 15px; background-color: #e8f5e9; border-radius: 6px; font-size: 15px; font-weight: bold; color: #2e7d32; border-left: 5px solid #4caf50; text-align: center; }
    </style>
</head>
<body>

    <div style="background-color: #ffffff; width: 100%; font-family: Arial, sans-serif; color: #333333; padding-top: 15px; border-bottom: 1px solid #e5e5e5;">
        <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 0 20px; box-sizing: border-box;">
            
            <div style="display: flex; gap: 25px; font-size: 13px; font-weight: bold; letter-spacing: 0.3px;">
                <a href="#" style="color: #128c46; text-decoration: none; text-transform: uppercase;">HỆ THỐNG TỔNG</a>
                <a href="#" style="color: #777777; text-decoration: none; text-transform: uppercase;">BÁO CÁO TỒN KHO</a>
                <a href="#" style="color: #777777; text-decoration: none; text-transform: uppercase;">ĐỐI TÁC CUNG ỨNG</a>
            </div>
            
            <div style="display: flex; align-items: center; gap: 12px;">
                <div style="width: 45px; height: 45px; background-color: #e8f5e9; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 22px; color: #128c46;">
                    🍃
                </div>
                <div style="display: flex; flex-direction: column;">
                    <span style="font-size: 22px; font-weight: 900; color: #128c46; letter-spacing: 0.5px; line-height: 1.1;">GREEN ECO-MARKET</span>
                    <span style="font-size: 10.5px; color: #666666; font-weight: bold; letter-spacing: 0.5px; text-transform: uppercase; margin-top: 2px;">Hệ thống tổng kho thực phẩm sạch</span>
                </div>
            </div>

            <div style="width: 220px;"></div>
        </div>

        <div style="background-color: #128c46; width: 100%; margin-top: 15px;">
            <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: flex-start; gap: 35px; padding: 14px 20px; font-size: 13.5px; font-weight: bold; color: #ffffff; box-sizing: border-box; text-transform: uppercase;">
                <a href="${pageContext.request.contextPath}/timsanpham" style="color: #ffffff; text-decoration: none; cursor: pointer;">Trang chủ dữ liệu</a>
                <div style="cursor: pointer;">Quản lý xuất nhập kho</div>
                <div style="cursor: pointer;">Cấu hình hệ thống</div>
            </div>
        </div>
    </div>

    <div class="container">
        
        <div class="content-card">
            <h2>🌡️ Chuyển Đổi Nhiệt Độ</h2>
            <form action="<%= request.getContextPath() %>/chuyendoi" method="post">
                <input type="hidden" name="type" value="temperature">
                <div class="form-group">
                    <label>Nhập giá trị độ C (°C):</label>
                    <input type="text" name="km" class="form-input" placeholder="Ví dụ: 37" 
                           value="<%= request.getAttribute("oldCelsius") != null ? request.getAttribute("oldCelsius") : "" %>" required>
                </div>
                <button type="submit" class="btn-submit">Chuyển sang độ F</button>
            </form>

            <% if (request.getAttribute("result") != null) { %>
                <div class="result-box" style="margin-top: 25px;">
                    <%= request.getAttribute("result") %>
                </div>
            <% } %>
        </div>

        <div class="content-card">
            <h2>💵 Chuyển Đổi Tiền Tệ (Tỷ giá: 25.450)</h2>
            <form action="<%= request.getContextPath() %>/chuyendoi" method="post">
                <input type="hidden" name="type" value="currency">
                <div class="form-group">
                    <label>Nhập số tiền USD ($):</label>
                    <input type="text" name="usdAmount" class="form-input" placeholder="Ví dụ: 10" 
                           value="<%= request.getAttribute("oldUsd") != null ? request.getAttribute("oldUsd") : "" %>" required>
                </div>
                <button type="submit" class="btn-submit">Chuyển sang Việt Nam Đồng</button>
            </form>

            <% if (request.getAttribute("currencyResult") != null) { %>
                <div class="result-box" style="margin-top: 25px;">
                    <%= request.getAttribute("currencyResult") %>
                </div>
            <% } %>
        </div>

    </div>

</body>
</html>