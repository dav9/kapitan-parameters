local kap = import "lib/kapitan.libjsonnet";
local inventory = kap.inventory();

{
  type: {
    type: inventory.parameters.type
  }
}
