export const BellPlugin = async ({ $ }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await $`printf '\a' > /dev/tty`;
      }
    },
  };
};
