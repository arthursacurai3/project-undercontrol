import { PrismaClient } from '@prisma/client'
import { Type, defaultFields, Method } from './default-fields'

const prisma = new PrismaClient()

async function createTypeDefaultFields(_type: Type) {
    await prisma.type.create({
        data: {
            name: _type.name,
            definition: _type.definition
        }
    })
}

async function createCategoryDefaultFields(_category: string) {
    await prisma.category.create({
        data: { name: _category }
    })
}

async function createMethodDefaultFields(_method: Method) {

    await prisma.method.create({
        data: {
            name: _method.name,
            bank: _method.bank || undefined
        }
    })

}

async function main() {
    await prisma.register.deleteMany()
    await prisma.type.deleteMany()
    await prisma.category.deleteMany()
    await prisma.method.deleteMany()
    await prisma.recurrence.deleteMany()

    defaultFields.types.map((el) => {
        createTypeDefaultFields(el)
    })

    defaultFields.categories.map((el) => {
        createCategoryDefaultFields(el)
    })

    defaultFields.methods.map((el) => {
        createMethodDefaultFields(el)
    })
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })