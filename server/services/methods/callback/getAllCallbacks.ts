import prisma from "../../../../prisma/prisma";

async function getAllCallbacks(props: any) {

    try{

        const gettingCallbacks = await prisma.callback.findMany({
            orderBy: {
                createdAt: 'desc'
            }
        })

        return {
            message: "Success",
            data: gettingCallbacks  
        }

        

    } catch (error) {
        return {
            message: "No data received",
            error: error

        }
    }

}

export default getAllCallbacks;