import prisma from "~/lib/prisma";
import type LoginRequest from "@Types/auth/loginRequest";
import argon2 from "argon2";
import * as jose from "jose";

export default defineEventHandler(async (event) => {
  const { email, password } = (await readBody(event)) as LoginRequest;
  if (password === undefined || email === undefined) {
    throw createError({
      statusCode: 400,
      message: "incorrect fields",
    });
  }

  const user = await prisma.admin.findUnique({
    where: {
      email: email,
    },
  });

  if ("" === user?.password || null === user) {
    setResponseStatus(event, 403);
    return {
      status: "NOK",
      message: "Cannot log-in",
    };
  }

  const passwordIsValid = await argon2.verify(user.password, password);

  if (false === passwordIsValid) {
    setResponseStatus(event, 403);
    return {
      status: "NOK",
      message: "Cannot log-in",
    };
  }

  const { jwtPrivateKey, jwtPublicKey } = useRuntimeConfig(event);
  const alg = "EdDSA";

  const key = await jose.importPKCS8(jwtPrivateKey, alg);
  const jwt = await new jose.SignJWT({
    firstName: user.firstName,
    lastName: user.lastName,
    roles: user.roles,
    id: user.externalId,
    email: user.email,
  })
    .setProtectedHeader({ alg })
    .setIssuedAt()
    .setIssuer("poolsideApp")
    .setAudience("poolsideApp")
    .setExpirationTime("1h")
    .sign(key);

  return jsonResponse({
    accessToken: jwt,
  });
});
