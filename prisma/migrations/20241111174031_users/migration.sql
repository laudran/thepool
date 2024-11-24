/*
  Warnings:

  - You are about to drop the `Admin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Client` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Contract` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Electrician` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Organization` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Person` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Plumber` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Pool` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PoolPersonSchedule` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Contract" DROP CONSTRAINT "Contract_clientId_fkey";

-- DropForeignKey
ALTER TABLE "Contract" DROP CONSTRAINT "Contract_poolId_fkey";

-- DropForeignKey
ALTER TABLE "Person" DROP CONSTRAINT "Person_poolId_fkey";

-- DropForeignKey
ALTER TABLE "Pool" DROP CONSTRAINT "Pool_electricianId_fkey";

-- DropForeignKey
ALTER TABLE "Pool" DROP CONSTRAINT "Pool_plumberId_fkey";

-- DropForeignKey
ALTER TABLE "PoolPersonSchedule" DROP CONSTRAINT "PoolPersonSchedule_personId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_organizationId_fkey";

-- DropTable
DROP TABLE "Admin";

-- DropTable
DROP TABLE "Client";

-- DropTable
DROP TABLE "Contract";

-- DropTable
DROP TABLE "Electrician";

-- DropTable
DROP TABLE "Organization";

-- DropTable
DROP TABLE "Person";

-- DropTable
DROP TABLE "Plumber";

-- DropTable
DROP TABLE "Pool";

-- DropTable
DROP TABLE "PoolPersonSchedule";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "client" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "userId" INT8 NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),
    "status" "ClientStatus" NOT NULL DEFAULT 'ACTIVE',
    "organizationId" INT8 NOT NULL,

    CONSTRAINT "client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contract" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "clientId" INT8 NOT NULL,
    "contractType" "ContractType" NOT NULL DEFAULT 'TREATMENT',
    "status" "ContractStatus" NOT NULL DEFAULT 'PENDING',
    "poolId" INT8 NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "contract_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pool" (
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
    "updatedAt" TIMESTAMP(3),
    "plumberId" INT8 NOT NULL,
    "electricianId" INT8 NOT NULL,

    CONSTRAINT "pool_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "person" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "poolId" INT8 NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "country" STRING NOT NULL,
    "isContact" BOOL NOT NULL,
    "isEmergencyContact" BOOL NOT NULL,
    "frequency" "PersonPresenceFrequency" NOT NULL DEFAULT 'YEARLY',
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pool_person_schedule" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "personId" INT8 NOT NULL,
    "type" "PoolPersonScheduleType" NOT NULL DEFAULT 'PRESENCE',
    "emergencyContact" BOOL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "pool_person_schedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plumber" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "email" STRING,
    "address" STRING,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "plumber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "electrician" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "email" STRING,
    "address" STRING,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "electrician_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "organization" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "email" STRING NOT NULL,
    "addressLine" STRING NOT NULL,
    "addressComplement" STRING,
    "zipCode" STRING NOT NULL,
    "country" STRING NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "email" STRING NOT NULL,
    "password" STRING NOT NULL,
    "organizationId" INT8 NOT NULL,
    "roles" STRING[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "lastName" STRING NOT NULL,
    "email" STRING NOT NULL,
    "password" STRING NOT NULL,
    "roles" STRING[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3),

    CONSTRAINT "admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "email" STRING NOT NULL,
    "password" STRING NOT NULL,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ClientUsers" (
    "A" INT8 NOT NULL,
    "B" INT8 NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "client_userId_key" ON "client"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "plumber_name_key" ON "plumber"("name");

-- CreateIndex
CREATE UNIQUE INDEX "electrician_name_key" ON "electrician"("name");

-- CreateIndex
CREATE UNIQUE INDEX "organization_name_key" ON "organization"("name");

-- CreateIndex
CREATE UNIQUE INDEX "employee_email_key" ON "employee"("email");

-- CreateIndex
CREATE UNIQUE INDEX "admin_email_key" ON "admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "user_email_key" ON "user"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_ClientUsers_AB_unique" ON "_ClientUsers"("A", "B");

-- CreateIndex
CREATE INDEX "_ClientUsers_B_index" ON "_ClientUsers"("B");

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "client" ADD CONSTRAINT "client_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contract" ADD CONSTRAINT "contract_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contract" ADD CONSTRAINT "contract_poolId_fkey" FOREIGN KEY ("poolId") REFERENCES "pool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pool" ADD CONSTRAINT "pool_plumberId_fkey" FOREIGN KEY ("plumberId") REFERENCES "plumber"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pool" ADD CONSTRAINT "pool_electricianId_fkey" FOREIGN KEY ("electricianId") REFERENCES "electrician"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "person" ADD CONSTRAINT "person_poolId_fkey" FOREIGN KEY ("poolId") REFERENCES "pool"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pool_person_schedule" ADD CONSTRAINT "pool_person_schedule_personId_fkey" FOREIGN KEY ("personId") REFERENCES "person"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee" ADD CONSTRAINT "employee_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClientUsers" ADD CONSTRAINT "_ClientUsers_A_fkey" FOREIGN KEY ("A") REFERENCES "client"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClientUsers" ADD CONSTRAINT "_ClientUsers_B_fkey" FOREIGN KEY ("B") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;
