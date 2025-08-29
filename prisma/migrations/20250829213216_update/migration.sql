-- CreateEnum
CREATE TYPE "public"."SubscriptionPlanStatus" AS ENUM ('active', 'deactivate', 'test');

-- CreateTable
CREATE TABLE "public"."SubscriptionPlan" (
    "id" TEXT NOT NULL,
    "subName" TEXT NOT NULL,
    "subAmount" INTEGER NOT NULL,
    "subDescription" TEXT NOT NULL,
    "subStatus" "public"."SubscriptionPlanStatus" NOT NULL,

    CONSTRAINT "SubscriptionPlan_pkey" PRIMARY KEY ("id")
);
