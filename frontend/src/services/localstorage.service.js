
class LocalStorage {
  writeAuth(token) {
    localStorage.setItem("isLogedIn", "true");
    localStorage.setItem('token', token)
  }

  readAuth() {
    let state = localStorage.getItem("isLogedIn");
    console.log("Reading state of isLogedIn" + state);
    if (state === undefined || state === null){
      return false;
    }
    return state;
  }

  deleteAuth() {
    localStorage.removeItem("isLogedIn");
    localStorage.removeItem('token');
  }
}

const LOCALSTORAGE_INSTANCE = new LocalStorage();

export { LOCALSTORAGE_INSTANCE };
