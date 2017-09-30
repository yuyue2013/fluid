import qbs 1.0

LiriQmlPlugin {
    name: "fluidcoreplugin"
    pluginPath: "Fluid/Core"

    Depends { name: "Qt"; submodules: ["svg", "gui"]; versionAtLeast: project.minimumQtVersion }
    Depends {
        condition: qbs.targetOS.contains("linux")
        name: "Qt"
        submodules: ["waylandclient", "waylandclient-private"]
        versionAtLeast: project.minimumQtVersion
        required: false
    }
    Depends { name: "Android.ndk"; condition: qbs.targetOS.contains("android") }

    Properties {
        condition: qbs.targetOS.contains("android")
        architectures: !qbs.architecture ? ["x86", "armv7a"] : undefined
        Android.ndk.appStl: "gnustl_shared"
    }

    cpp.defines: base.concat(['FLUID_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "qmldir", "*.qml", "*.qmltypes"]
}
