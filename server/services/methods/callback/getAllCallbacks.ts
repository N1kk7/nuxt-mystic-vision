import prisma from "../../../../prisma/prisma";

async function getAllCallbacks() {

    console.log('enter getAllCallbacks 1');

    try{

        const gettingCallbacks = await prisma.callback.findMany({
            orderBy: {
                createdAt: 'desc'
            }
        })

        console.log(gettingCallbacks, 'gettingCallbacks');

        return {
            message: "Success",
            data: gettingCallbacks  
        }

        

    } catch (error) {
        console.error("Prisma callback.findMany error:", error);
        return {
            message: "No data received",
            error: error

        }
    }

}

export default getAllCallbacks;