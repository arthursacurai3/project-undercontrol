// ------- types -------
export type Type = {
    name: string,
    definition: string
}

const fixed_expenses: Type = {
    name: 'Despesas fixas',
    definition: 'Depesas fixas e recorrentes, Ex: aluguel, iptu, internet, etc.'
}

const fixed_expenses_variable_value: Type = {
    name: 'Despesas fixas com valor variável',
    definition: 'Depesas/gastos fixos com valor variável, Ex: Luz, água, etc.'
}

const variable_expenses: Type = {
    name: 'Despesas/gastos variáveis',
    definition: 'Depesas/gastos variáveis, Ex: restaurante, novo carro, etc.'
}

const investments: Type = {
    name: 'Investimentos',
    definition: 'Investimentos realizados, Ex: mercado de ações, terreno, empresa, etc.'
}

const savings: Type = {
    name: 'Guardar',
    definition: 'Dinheiro guardado, Ex: Reserva de emergência'
}

const income: Type = {
    name: 'Renda',
    definition: 'Renda'
}

// ------- Category -------
export type Category = string[]

const categories = [
    'Alimentação',
    'Combustível',
    'Dentista',
    'Remédio',
    'Hospital',
    'Suplementação',
    'Bens Eletrônicos',
    'Automóvel',
    'Moradia',
    'Academia',
    'Supermercado',
    'Cursos',
    'Faculdade',
    'Escola',
    'Material escolar',
    'Esporte',
    'Salário',
    'Trabalho',
    'Rendimento investimento'
]

// ------- methodies -------
export type Method = {
    name: string,
    bank?: string
}

const banksArr = [
    'Banco do Brasil',
    'Nubank'
    // 'Caixa',
    // 'Itaú',
    // 'Santander',
    // 'Bradesco',
    // 'Safra',
    // 'Inter',
    // 'C6 Bank',
    // 'Pic Pay',
    // 'Neo'
]

const money: Method = {
    name: 'Dinheiro'
}

let credit_card_arr: Array<Method> = []
let debit_card_arr: Array<Method> = []
let pix_arr: Array<Method> = []
let ted_arr: Array<Method> = []
let doc_arr: Array<Method> = []

banksArr.map(el => {
    credit_card_arr.push({
        name: 'Cartão de Crédito',
        bank: el
    })

    debit_card_arr.push({
        name: 'Cartão de Débito',
        bank: el
    })

    pix_arr.push({
        name: 'Pix',
        bank: el
    })

    ted_arr.push({
        name: 'TED',
        bank: el
    })

    doc_arr.push({
        name: 'DOC',
        bank: el
    })
})


// ------- all default fields --------

export const defaultFields = {
    types: [
        fixed_expenses,
        fixed_expenses_variable_value,
        variable_expenses,
        investments,
        savings,
        income
    ],

    categories,

    methods: [
        money,
        ...credit_card_arr,
        ...debit_card_arr,
        ...pix_arr,
        ...ted_arr,
        ...doc_arr,
    ]

}
