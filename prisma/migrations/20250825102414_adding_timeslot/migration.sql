/*
  Warnings:

  - Added the required column `timeSlot` to the `Callback` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."Callback" ADD COLUMN     "timeSlot" TEXT NOT NULL;
