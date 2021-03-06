// Comment to get more information during initialization
logLevel := Level.Warn

// The Typesafe repository 
resolvers += "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/"

resolvers += "Sonatype OSS Snapshots" at "https://oss.sonatype.org/content/repositories/snapshots"

// Use the Play sbt plugin for Play projects
addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.2.0")

val appDependencies = Seq(
   "com.google.guava" % "guava" % "14.0-rc1",
   "com.jolbox" % "bonecp" % "0.8.0-rc3-SNAPSHOT"
) 
