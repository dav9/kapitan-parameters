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

If the class tries to reference a parameter in its classes declaration the same problem appears, however the parameters can be used in the dependencies section:

```yaml
parameters:
  version: 1

  kapitan:
    dependencies:
    - type: git
      source: git@github.com:dav9/kapitan-parameters.git
      ref: main
      output_path: copy_of_repository/${version}
```

The version parameter can be used in the output_path for a dependency.

The order is as well important, the following works:

```yaml
classes: 
- version
- component.${version}.main
```

The following does not work:

```yaml
classes: 
- component.${version}.main
- version
```

In a nutshell: a class reference in a class or target can be interpolated only with parameters defined in classes that are referenced before it; it cannot see parameters defined in the same class or target.