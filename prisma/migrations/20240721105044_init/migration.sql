/*
  Warnings:

  - Added the required column `country` to the `Person` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isContact` to the `Person` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isEmergencyContact` to the `Person` table without a default value. This is not possible if the table is not empty.
  - Added the required column `electricianId` to the `Pool` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plumberId` to the `Pool` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Person" ADD COLUMN     "country" STRING NOT NULL;
ALTER TABLE "Person" ADD COLUMN     "isContact" BOOL NOT NULL;
ALTER TABLE "Person" ADD COLUMN     "isEmergencyContact" BOOL NOT NULL;

-- AlterTable
ALTER TABLE "Pool" ADD COLUMN     "electricianId" INT8 NOT NULL;
ALTER TABLE "Pool" ADD COLUMN     "plumberId" INT8 NOT NULL;

-- CreateTable
CREATE TABLE "Plumber" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "email" STRING,
    "address" STRING,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Plumber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Electrician" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "phone" STRING NOT NULL,
    "email" STRING,
    "address" STRING,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Electrician_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Organization" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "email" STRING,
    "addressLine" STRING NOT NULL,
    "addressComplement" STRING NOT NULL,
    "zipCode" STRING NOT NULL,
    "country" STRING NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Organization_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "email" STRING NOT NULL,
    "password" STRING NOT NULL,
    "organizationId" INT8 NOT NULL,
    "roles" STRING[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Admin" (
    "id" INT8 NOT NULL DEFAULT unique_rowid(),
    "externalId" STRING NOT NULL,
    "name" STRING NOT NULL,
    "firstName" STRING NOT NULL,
    "email" STRING NOT NULL,
    "password" STRING NOT NULL,
    "roles" STRING[],
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Plumber_name_key" ON "Plumber"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Electrician_name_key" ON "Electrician"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Organization_name_key" ON "Organization"("name");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- AddForeignKey
ALTER TABLE "Pool" ADD CONSTRAINT "Pool_plumberId_fkey" FOREIGN KEY ("plumberId") REFERENCES "Plumber"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pool" ADD CONSTRAINT "Pool_electricianId_fkey" FOREIGN KEY ("electricianId") REFERENCES "Electrician"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
