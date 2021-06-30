# Kapitan and Targets

## Loading of Targets
Kapitan loads all targets even if it will compile only one

```sh
kapitan compile -t basic
```

fails with:

```
Inventory reclass error: -> 
   Inventory Queries:
   -> not_working_with_param
      In yaml_fs:///.../inventory/targets/not_working_with_param.yml
      Class name component.${version}.main not resolvable


-> 
   Inventory Queries:
   -> not_working_with_param
      In yaml_fs:///.../inventory/targets/not_working_with_param.yml
      Class name component.${version}.main not resolvable
```

After `mv inventory/targets/not_working_with_param.yml inventory/targets/not_working_with_param` it compiles only basic target.

## Parameters from the Same Class or Target

The difference between [not_working_with_param.yml](inventory/targets/not_working_with_param.yml) and [working_with_param_class.yml](inventory/targets/working_with_param_class.yml) is that the version parameter is defined inside the target, and in the second it is a class that is referenced.

If the class tries to reference a parameter in its classes declaration the same problem appears, however the parameters can be used in the dependencies section. 