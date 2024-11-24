import { PrismaClient, EmployeeRole } from "@prisma/client";
import argon2 from "argon2";
const prisma = new PrismaClient();
async function main() {
  const admin = await prisma.admin.upsert({
    where: { email: "admin@poolside.com" },
    update: {},
    create: {
      email: "admin@poolside.com",
      name: "Admin",
      firstName: "Admin",
      lastName: "Admin",
      password: (await argon2.hash("poilsideAdmin")).toString(),
      roles: ["admin"],
    },
  });

  const organization = await prisma.organization.upsert({
    where: { name: "eauvive" },
    update: {},
    create: {
      name: "eauvive",
      email: "eauvive@poolside.com",
      addressLine: "8 rue du maco",
      zipCode: "97139",
      country: "guadeloupe",
      users: {
        create: {
          name: "Eauvive Owner",
          firstName: "Owner",
          lastName: "Maco",
          email: "owner@eauvive.com",
          password: (await argon2.hash("outromaco")).toString(),
          roles: [EmployeeRole.USER, EmployeeRole.OWNER],
        },
      },
    },
  });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
