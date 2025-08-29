/*
  Warnings:

  - Added the required column `paymentLink` to the `SubscriptionPlan` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."SubscriptionPlan" ADD COLUMN     "paymentLink" TEXT NOT NULL;
