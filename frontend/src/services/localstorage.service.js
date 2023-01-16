class LocalStorage {
  writeAuth(token) {
    localStorage.setItem('isLogedIn', 'true')
    localStorage.setItem('token', token)
  }

  readAuth() {
    const state = localStorage.getItem('isLogedIn')
    if (state === undefined || state === null) {
      return false
    }
    return state
  }

  deleteAuth() {
    localStorage.removeItem('isLogedIn')
    localStorage.removeItem('token')
  }

  getToken() {
    return localStorage.getItem('token')
  }
}

const LOCALSTORAGE_INSTANCE = new LocalStorage()

export { LOCALSTORAGE_INSTANCE }
