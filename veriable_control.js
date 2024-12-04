const login = {
    TextFormField: string,
}
const register = {
    TextFormField: string,
}

const HomePage = {
    _selectedYear: int,
    _selectedMonth: int,
    selectedDate: string('$_selectedYear年$_selectedMonth月'),
    totalBudget: int,
    consumed: int,
    remaining: int,
    bills: List < Map < String, dynamic>> (testData),
}
const HomeAppBar = {
    selectedDate: string('$_selectedYear年$_selectedMonth月'),
}

const BudgetSummary = {
    totalBudget: int,
    consumed: int,
    remaining: int,
}

const BillList = {
    bills: List < Map < String, dynamic>> (testData),
}

const createPage = {
    //这里列出的是需要通过回调函数存入数据库的变量
    _selectedYear: int,
    _selectedMonth: int,
    _selectedDay: int,
    selectedCategory: string,
    _selectedAmount: int,
    _selectedNote: string,
}