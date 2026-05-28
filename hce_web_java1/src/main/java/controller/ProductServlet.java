package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/products") 
public class ProductServlet extends HttpServlet {

    public static class Product {
        private String id;
        private String name;
        private String category; 
        private double price;
        private String imageUrl;

        public Product(String id, String name, String category, double price, String imageUrl) {
            this.id = id;
            this.name = name;
            this.category = category;
            this.price = price;
            this.imageUrl = imageUrl;
        }
        public String getId() { return id; }
        public String getName() { return name; }
        public String getCategory() { return category; }
        public double getPrice() { return price; }
        public String getImageUrl() { return imageUrl; }
    }

    private List<Product> listSp = new ArrayList<>();

    @Override
    public void init() throws ServletException {
        listSp.clear(); // Xóa sạch dữ liệu cũ tránh trùng lặp

        // ==================== 1. CHUỘT (MOUSE) ====================
        listSp.add(new Product("CH001", "Chuột Gaming Logitech G102 LightSync", "Chuột", 450000, 
            "https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("CH002", "Chuột Không Dây Logitech MX Master 3S", "Chuột", 2490000, 
            "https://images.unsplash.com/photo-1605773527852-c543735f179e?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("CH003", "Chuột Gaming Razer DeathAdder V3 Pro", "Chuột", 3590000, 
            "https://images.unsplash.com/photo-1625600243103-1dc6824c6c8a?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("CH004", "Chuột Không Dây Asus ROG Keris", "Chuột", 1690000, 
            "https://images.unsplash.com/photo-1617317112836-3914a572a11b?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("CH005", "Chuột Văn Phòng Sleek Tech Không Dây", "Chuột", 120000, 
            "https://images.unsplash.com/photo-1631009185095-e76346885508?w=200&auto=format&fit=crop&q=80"));

        // ==================== 2. MÀN HÌNH (MONITOR) ====================
        listSp.add(new Product("MH001", "Màn hình Dell UltraSharp U2422H 24 inch IPS", "Màn hình", 6350000, 
            "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("MH002", "Màn hình Gaming ASUS TUF VG249Q3A 180Hz", "Màn hình", 4190000, 
            "https://images.unsplash.com/photo-1551645121-d1034da75057?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("MH003", "Màn hình Cong Samsung Odyssey G5 27 inch", "Màn hình", 7490000, 
            "https://images.unsplash.com/photo-1547119957-637f8679db1e?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("MH004", "Màn hình LG Đồ Họa 27UP855N 4K IPS", "Màn hình", 9200000, 
            "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("MH005", "Màn hình Văn Phòng MSI Pro MP223 21.5 inch", "Màn hình", 1990000, 
            "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=200&auto=format&fit=crop&q=80"));

        // ==================== 3. BÀN PHÍM (KEYBOARD) ====================
        listSp.add(new Product("BP001", "Bàn phím cơ Logitech G Pro X TKL", "Bàn phím", 3190000, 
            "https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("BP002", "Bàn phím cơ Akko 3068B Plus Blue on White", "Bàn phím", 1550000, 
            "https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("BP003", "Bàn phím Cơ Không Dây Keychron K2 V2", "Bàn phím", 1890000, 
            "https://images.unsplash.com/photo-1595225476474-87563907a212?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("BP004", "Bàn phím cao cấp Razer BlackWidow V4", "Bàn phím", 4690000, 
            "https://images.unsplash.com/photo-1601445638532-3c6f6c3aa1d6?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("BP005", "Bàn phím Văn Phòng Dell KB216 Đen Sleek", "Bàn phím", 180000, 
            "https://images.unsplash.com/photo-1626958390898-162d3577f593?w=200&auto=format&fit=crop&q=80"));

        // ==================== 4. TAI NGHE (HEADPHONES) ====================
        listSp.add(new Product("TN001", "Tai nghe Chụp Tai Không Dây Sony WH-1000XM5", "Tai nghe", 6890000, 
            "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("TN002", "Tai nghe Gaming HyperX Cloud III Red", "Tai nghe", 2190000, 
            "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("TN003", "Tai nghe Chụp Tai Hires Audio Audio-Technica", "Tai nghe", 3450000, 
            "https://images.unsplash.com/photo-1484704849700-f032a568e944?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("TN004", "Tai nghe Gaming Chụp Tai JBL Quantum 100", "Tai nghe", 790000, 
            "https://images.unsplash.com/photo-1583394838336-acd977736f90?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("TN005", "Tai nghe Bluetooth Apple AirPods Max", "Tai nghe", 13200000, 
            "https://images.unsplash.com/photo-1577174881658-0f30ed549adc?w=200&auto=format&fit=crop&q=80"));

        // ==================== 5. Ổ CỨNG (STORAGE) ====================
        listSp.add(new Product("OC001", "Ổ cứng SSD Samsung 990 Pro 1TB M.2 NVMe", "Ổ cứng", 2790000, 
            "https://images.unsplash.com/photo-1600541519468-4a9121def1b1?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("OC002", "Ổ cứng SSD Kingston NV2 500GB PCIe Gen4", "Ổ cứng", 950000, 
            "https://images.unsplash.com/photo-1555532538-dcdbd01d373d?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("OC003", "Ổ cứng Di Động SSD SanDisk Extreme E61 1TB", "Ổ cứng", 2550000, 
            "https://images.unsplash.com/photo-1562813733-b31f71025d54?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("OC004", "Ổ cứng HDD WD Blue 1TB 3.5 inch SATA 3", "Ổ cứng", 1150000, 
            "https://images.unsplash.com/photo-1591799264318-7e6ef8ddb7ea?w=200&auto=format&fit=crop&q=80"));
        listSp.add(new Product("OC005", "Ổ cứng SSD Crucial BX500 480GB SATA III", "Ổ cứng", 820000, 
            "https://images.unsplash.com/photo-1618532158724-bdfd403525ce?w=200&auto=format&fit=crop&q=80"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("search");
        List<Product> ketQua = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            ketQua = listSp;
        } else {
            String searchKey = keyword.toLowerCase().trim();
            for (Product p : listSp) {
                if (p.getName().toLowerCase().contains(searchKey) || 
                    p.getCategory().toLowerCase().contains(searchKey)) {
                    ketQua.add(p);
                }
            }
        }

        request.setAttribute("dsSanPham", ketQua);
        request.setAttribute("tuKhoa", keyword);

        // Chuyển hướng sang file hiển thị tương ứng của bạn
        request.getRequestDispatcher("/product.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}