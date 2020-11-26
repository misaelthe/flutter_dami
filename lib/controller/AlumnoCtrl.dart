class AlumnoCtrl {

  DBCibertec con = new DBCibertec();
  MainService service = new MainService();

  Future<int> getIdDocente() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int idAlumno = preferences.getInt("idusuario");
    Alumno d = await service.getAlumnosByClase(idclase);
    return d.idalumno;
  }

  getClasesByAlumno(int idalumno) async {
    return await service.getClasesByAlumno(idalumno);
  }



  getCursoByClase(int idclase) async {
    return await service.getCursoByClase(idclase);
  }
}
