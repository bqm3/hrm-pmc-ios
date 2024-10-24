class URLHelper {
  static String baseUrl = "https://apihrm.pmcweb.vn";

  static String urlRequest = "$baseUrl/api/";

  static const String Nhan_Su = "NhanSu/GetList";
  static const String Login = "Auth/Login";
  static const String NS_Information = "NhanSu/GetInfoByCode";
  static const String NS_quanhe = "NhanSuQH/GetListByCode";
  static const String NS_congtactr = "NhanSuQTCT/GetListBeforeByCode";
  static const String NS_hocvan = "NhanSuHV/GetListByCode";
  static const String NS_congtac = "NhanSuQTCT/GetListByCode";
  static const String NS_khenthuong = "NhanSuKT/GetListByCode";
  static const String NS_kyluat = "NhanSuKL/GetListByCode";
  static const String NS_qlLuong = "NhanSuQTL/GetListByCode";
  static const String NS_InforUpdate = "NhanSu/Update";
  static const String NS_NotApproved = "NhanSu/CheckExistsUpdate";
  static const String NS_Token = "Token/Create";
  static const String DM_DiaDiem = "DiaDiem/GetListByCode";
  static const String DM_CaLam = "CaLamViec/GetListByCode";
  static const String DM_DOIMK = "NhanSu/ChangePassword";
  static const String NS_ChamCong = "ChamCong/Create";
  static const String NS_CheckVao = "ChamCong/CheckNhanSuCheckIn";
  static const String NS_CheckRa = "ChamCong/CheckNhanSuCheckOut";
  static const String NS_UpdateNS = "NhanSu/Update";
  static const String NS_ThongBao = "ThongBao/GetList";
  static const String DM_LoaiNghi = "DanhMuc/GetList";
  static const String DM_NghiPhep = "NghiPhep/GetList";
  static const String NS_ListChamCong = "ChamCong/GetList";
  static const String NS_XetDuyet = "XetDuyet/GetList";
  static const String DM_Regsystem = "RegSystem/GetValueByCode";
  static const String NS_BangLuong = "BangLuong/GetInfoByCode";
  static const String NS_DaoTao = "DaoTao/GetLichDaoTao";
  static const String DM_LoaiDaoTao = "DaoTao/GetListByCode";
  static const String NS_DeNghi = "NhanSuDN/GetListByCode";
  static const String NS_DoiCa = "DoiCa";
  static const String NS_ListCa = "CaLamViec/GetList";
  static const String NS_NghiPhepDetail = "NghiPhep/GetListChiTiet";
  static const String NS_ListDaoTao = "DaoTao/GetListDangKyByNhanSu";
  static String danhMuc = "DanhMuc/GetList";
}
