import { prisma } from './lib/prisma'
import { FastifyInstance, FastifyRequest } from 'fastify'
import { z } from 'zod'

export async function appRoutes(app: FastifyInstance) {

    app.post('/recurrence', async (request, reply) => {
        const createRecurrenceBody = z.object({ 
            frequency: z.string(),
            repeat_every: z.number(),
            repeat_when: z.string().optional(),
            end_date: z.date().optional(),
            end_after_repeated_times: z.number().optional(),
            medium_value: z.number().optional(),
            medium_tax: z.number().optional()
        })

        const {
            frequency,
            repeat_every,
            repeat_when,
            end_date,
            end_after_repeated_times,
            medium_value,
            medium_tax
        } = createRecurrenceBody.parse(request.body)

        const result = await prisma.recurrence.create({
            data: {
                frequency,
                repeat_every,
                repeat_when,
                end_date,
                end_after_repeated_times,
                medium_value,
                medium_tax
            }
        })
        
        reply.send(result)
    })

    app.post('/registers', async (request ,reply) => {
        const createRegisterBody = z.object({
            title: z.string(),
            value: z.number(),
            pendingStatus: z.boolean(),
            date: z.string(),
            category_id: z.string().optional(),
            type_id: z.string().optional(),
            method_id: z.string().optional(),
            recurrence_id: z.number().optional()
        })

        const {
            title,
            value,
            pendingStatus,
            date,
            category_id,
            type_id,
            method_id,
            recurrence_id
        } = createRegisterBody.parse(request.body)

        const _date = new Date(date)

        const result = await prisma.register.create({
            data: {
                title: title,
                value: value,
                pendingStatus: pendingStatus,
                date: _date,
                category_id: category_id,
                type_id: type_id,
                method_id : method_id,
                recurrence_id: recurrence_id
            }
        })
        
        reply.send(result)
    })

    // post entity type and method
    // get registers
    // get summary

    app.get('/types', async (request) => {
        const types = await prisma.type.findMany({
            orderBy: [
                { name: 'asc' }
            ]
        })
        return types
    })

    app.get('/types-filter', async (request) => {
        const arrIds = z.array(z.string())

        const typesIds = arrIds.parse(request.query["arrIds[]"])

        const response = await prisma.type.findMany({
            where: {
                id: {in: typesIds}
            }
        })
        return response
    })

    app.get('/categories', async (request) => {
        const category = await prisma.category.findMany({
            orderBy: [
                { name: 'asc' }
            ]
        })
        return category
    })


    app.get('/category-filter', async (request) => {
        const arrIds = z.array(z.string())

        const categoryIds = arrIds.parse(request.query["arrIds[]"])

        const response = await prisma.category.findMany({
            where: {
                id: {in: categoryIds}
            }
        })
        return response
    })

    app.get('/methods', async (request) => {
        const methods = await prisma.method.findMany({
            orderBy: [
                { name: 'asc' }
            ]
        })
        return methods
    })


    app.get('/methods-filter', async (request) => {
        const arrIds = z.array(z.string())

        const methodsIds = arrIds.parse(request.query["arrIds[]"])

        const response = await prisma.method.findMany({
            where: {
                id: {in: methodsIds}
            }
        })
        return response
    })

    app.get('/summary', async () => {
        const summary = await prisma.$queryRaw`
            SELECT
                R.id,
                R.name,
                R.value,
                R.date,
                R.recurrence_id
            FROM registers R
        `
        return summary
    })

    app.get('/registers', async (request) => {
        const createRegistersBody = z.object({
            startDate: z.coerce.date(),
            endDate: z.coerce.date()
        })

        const {startDate, endDate} = createRegistersBody.parse(request.query)

        const registers = await prisma.register.findMany({
            where: {
                date: {
                    lte: endDate,
                    gte: startDate
                }
            },
            orderBy: [{date: 'desc'}]
        })

        return registers
    })

    app.get('/recurrence/last', async () => {
        const lastRecurrence = await prisma.recurrence.findFirst({
            orderBy: {
                id: "desc"
            }
        })

        return lastRecurrence?.id
    })


    app.delete('/recurrence/:id/delete', async (request) => {

    })

    app.delete('/register/:id/delete', async (request, reply) => {

        const idPassedToDelete = z.object({
            id: z.string().transform(Number)
        })

        const { id } = idPassedToDelete.parse(request.params)

        const result = await prisma.register.delete({
            where: {
                id: id
            }
        })

        reply.send(result)
    })

    app.delete('/register/:id/delete-many', async (request) => {
        const idPassedToDelete = z.object({
            id: z.string().transform(Number)
        })

        const { id } = idPassedToDelete.parse(request.params)

        const _register = await prisma.register.deleteMany({
            where: {
                recurrence_id: id
            }
        })

        await prisma.recurrence.deleteMany({
            where: {
                id: id
            }
        })

        return _register
    })
}
