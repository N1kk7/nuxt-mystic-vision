-- CreateEnum
CREATE TYPE "public"."Status" AS ENUM ('WAITING_CALL', 'PURCHASED');

-- CreateTable
CREATE TABLE "public"."Callback" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "contact" TEXT NOT NULL,
    "dateCallback" TIMESTAMP(3) NOT NULL,
    "orderTime" TEXT NOT NULL,
    "testRow" TEXT NOT NULL,
    "status" "public"."Status" NOT NULL DEFAULT 'WAITING_CALL',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Callback_pkey" PRIMARY KEY ("id")
);
