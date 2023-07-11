"use strict";

module.exports.helloworld = async (event) => {
  console.log(event);
  return {
    statusCode: 200,
    body: JSON.stringify(
      {
        message: `Hello, World!`,
        input: event,
      },
      null,
      2
    ),
  };
};
