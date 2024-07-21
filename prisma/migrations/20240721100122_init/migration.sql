-- CreateEnum
CREATE TYPE "ContractType" AS ENUM ('TREATMENT', 'CLEANING', 'OPENING', 'CLOSING');

-- CreateEnum
CREATE TYPE "ClientStatus" AS ENUM ('PENDING', 'ACTIVE', 'TERMINATED');

-- CreateEnum
CREATE TYPE "ContractStatus" AS ENUM ('PENDING', 'ACTIVE', 'END_SCHEDULED', 'TERMINATED');

-- CreateEnum
CREATE TYPE "PoolFillingType" AS ENUM ('TIMER', 'RAM', 'RAB', 'RAS', 'MANUAL');

-- CreateEnum
CREATE TYPE "PersonPresenceFrequency" AS ENUM ('YEARLY', 'RENT', 'PERIODICALLY');

-- CreateEnum
CREATE TYPE "PoolPersonScheduleType" AS ENUM ('PRESENCE', 'ABSENCE');

-- CreateEnum
CREATE TYPE "PoolType" AS ENUM ('OVERFLOWING', 'CLASSIC');

-- CreateTable
CREATE TABLE "Client" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "address" STRING NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "status" "ClientStatus" NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Contract" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "clientId" INT8 NOT NULL,
    "contractType" "ContractType" NOT NULL DEFAULT 'TREATMENT',
    "status" "ContractStatus" NOT NULL DEFAULT 'PENDING',
    "poolId" INT8 NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Contract_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pool" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "size" INT4,
    "chemicals" STRING,
    "fillingType" "PoolFillingType" NOT NULL,
    "hasTarp" BOOL NOT NULL,
    "tarpTtype" STRING,
    "hasStore" BOOL NOT NULL,
    "storeType" STRING,
    "poolType" "PoolType" NOT NULL DEFAULT 'CLASSIC',
    "hasSalt" BOOL NOT NULL,
    "saltOn" BOOL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Pool_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Person" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "poolId" INT8 NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "frequency" "PersonPresenceFrequency" NOT NULL DEFAULT 'YEARLY',
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PoolPersonSchedule" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "personId" INT8 NOT NULL,
    "type" "PoolPersonScheduleType" NOT NULL DEFAULT 'PRESENCE',
    "emergencyContact" BOOL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PoolPersonSchedule_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Contract" ADD CONSTRAINT "Contract_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Contract" ADD CONSTRAINT "Contract_poolId_fkey" FOREIGN KEY ("poolId") REFERENCES "Pool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_poolId_fkey" FOREIGN KEY ("poolId") REFERENCES "Pool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PoolPersonSchedule" ADD CONSTRAINT "PoolPersonSchedule_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
