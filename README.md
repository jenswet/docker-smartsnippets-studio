# docker-smartsnippets-studio
SmartSnippets Studio in a Docker container for CI builds

## CI Build
Run following snippet to trigger the build process.
```
/opt/DiaSemi/SmartSnippetsStudio2.0.12/CDT/SmartSnippets_Studio --launcher.suppressErrors -nosplash -application org.eclipse.cdt.managedbuilder.core.headlessbuild -data /path/to/workspace/ -import "/path/to/project" -cleanBuild "projectname/releaseconfig"
```
Discussion: https://support.dialog-semiconductor.com/forums/post/dialog-smartbond-bluetooth-low-energy-–-tools/build-project-gitlab-ci
