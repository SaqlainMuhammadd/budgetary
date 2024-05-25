class StaticValues {
  static String token = "";
  static const imageUrl = "https://snabbbudget.7skiessolutions.net/";
  static const registerUser = 'UserApi/RegsiterUser';
  static const loginUser = 'UserApi/UserLogin';
  static const forgotpassword = "UserApi/ForgotPassword?email=";

  static const addCategory = 'Categories/AddCategory';
  static const getCategories = 'Categories/GetCategories/';
  static const deleteCategories = 'Categories/DeleteCategory/';
  static const addTransaction = 'Transaction/AddTransaction';
  static const getAllTransaction = 'Transaction/GetAllTransactions';
  static const getBudgets = 'Budget/GetBudgets';
  static const addBudgets = 'Budget/Add';
  static const deleteBudgets = 'Budget/Delete';
  static const payBudgets = 'Budget/Pay';
  static const getWalletDetails = 'Wallet/GetCurrentStats';
  static const getProfileDetails = 'UserApi/UserProfile';
  static const updateProfileDetails = 'UserApi/UpdateProfile';
  static const getWalletList = 'Wallet/Get';
  static const addWalletData = 'Wallet/Add';
  static const deleteWalletData = 'Wallet/Delete/';
  static const changeCurrency = 'Wallet/ChangeCurrency?Currency=';
  static const getIncomeGraph = 'Wallet/GetMonthWiseIncome/';
  static const getIncomeExpenceGraph = 'Wallet/GetMonthWiseIncomeExpense/';
  static const changePassword = 'UserApi/ChangeUserPassword';
  static const getDailyTrasaction = 'Transaction/GetDayWiseTransactions';
  static const getMonthTrasaction = 'Transaction/GetMonthWiseTransactions';
  static const getYearTrasaction = 'Transaction/GetYearWiseTransactions';
  static const deleteTrasaction = 'Transaction/Delete/';
  static const getAllRecycleTrasaction = 'Transaction/GetDeletedTransactions';
  static const getTransactionstype = "Transaction/GetTransactions";
  static const recoverTrasaction = 'Transaction/Recover/';
  static const getSummary = 'Wallet/GetSummary?Date=';
  static const searchSummary = 'Wallet/SearchSummary?Type=';
  static const adddebitcredit = 'DebitCredit/Add';
  static const getdebitcredit = "DebitCredit/GetDebitCredit";
  static const paydebitcredit = "DebitCredit/Pay";
  static const updatedebitcredit = "DebitCredit/Update";
  static const deletedebitcredit = "DebitCredit/Delete";
  static const addcscheduleTransaction = "Transaction/AddSceduleTransaction";
  static const getscheduleTransaction =
      "Transaction/GetAllScheduleTransactions";
}
