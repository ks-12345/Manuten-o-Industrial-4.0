allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    if (name == "isar_flutter_libs") {
        afterEvaluate {
            val androidExtension = extensions.findByName("android")
            setCompileSdk(androidExtension, 36)
        }
    }
}

fun setCompileSdk(androidExtension: Any?, version: Int) {
    if (androidExtension == null) return

    val setCompileSdkMethod = androidExtension.javaClass.methods.firstOrNull { method ->
        method.name == "setCompileSdk" && method.parameterTypes.size == 1
    }
    if (setCompileSdkMethod != null) {
        setCompileSdkMethod.invoke(androidExtension, version)
        return
    }

    val compileSdkVersionMethod = androidExtension.javaClass.methods.firstOrNull { method ->
        method.name == "compileSdkVersion" && method.parameterTypes.size == 1
    }

    val compileSdkValue = when (compileSdkVersionMethod?.parameterTypes?.firstOrNull()) {
        Int::class.javaPrimitiveType,
        Int::class.javaObjectType,
        -> version

        String::class.java -> version.toString()
        else -> null
    }

    if (compileSdkVersionMethod != null && compileSdkValue != null) {
        compileSdkVersionMethod.invoke(androidExtension, compileSdkValue)
    }
}

subprojects {
    plugins.withId("com.android.library") {
        if (name == "isar_flutter_libs") return@withId

        val androidExtension = extensions.findByName("android")
        val setCompileSdkMethod = androidExtension?.javaClass?.methods?.firstOrNull { method ->
            method.name == "setCompileSdk" && method.parameterTypes.size == 1
        }
        val compileSdkVersionMethod = androidExtension?.javaClass?.methods?.firstOrNull { method ->
            method.name == "compileSdkVersion" && method.parameterTypes.size == 1
        }

        if (setCompileSdkMethod != null) {
            setCompileSdkMethod.invoke(androidExtension, 36)
            return@withId
        }

        val compileSdkValue = when (compileSdkVersionMethod?.parameterTypes?.firstOrNull()) {
            Int::class.javaPrimitiveType,
            Int::class.javaObjectType,
            -> 36

            String::class.java -> "36"
            else -> null
        }

        if (compileSdkVersionMethod != null && compileSdkValue != null) {
            compileSdkVersionMethod.invoke(androidExtension, compileSdkValue)
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
