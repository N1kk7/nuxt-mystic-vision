/*
  Warnings:

  - You are about to drop the column `subAmount` on the `SubscriptionPlan` table. All the data in the column will be lost.
  - Added the required column `monthlyAmount` to the `SubscriptionPlan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `yearlyAmount` to the `SubscriptionPlan` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "public"."SubscriptionPlan" DROP COLUMN "subAmount",
ADD COLUMN     "monthlyAmount" INTEGER NOT NULL,
ADD COLUMN     "yearlyAmount" INTEGER NOT NULL,
ALTER COLUMN "subDescription" DROP NOT NULL;
