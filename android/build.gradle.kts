<<<<<<< HEAD
=======
// ✅ أضيفي ده في أول الملف
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.google.gms:google-services:4.4.2")
    }
}

>>>>>>> 36fefe4dc9642771b3ded1fb7ba5d525a6761857
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

<<<<<<< HEAD
=======
// ✅ إعدادات build directories
>>>>>>> 36fefe4dc9642771b3ded1fb7ba5d525a6761857
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
<<<<<<< HEAD
=======

>>>>>>> 36fefe4dc9642771b3ded1fb7ba5d525a6761857
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
