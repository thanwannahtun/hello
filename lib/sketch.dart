class DataSource {
  getData() {}
  getDataById() {}

  updateData() {}

  deleteData() {}
}

class Bloc {
  late DataSource dataSource;
  getDta() {
    dataSource.getData();
  }
}
