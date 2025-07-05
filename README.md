PG27 Simone Cormier
Rendering and Shaders
Final Assignment

Notes:
You can find scenes in Assets>Scenes, the scripts in Assets>Scripts and the Shaders in Assets>Shaders.

Scene 1 - Baked Lighting:
In this scene I created a small scene and used lighmapping and baked shadows by creating baked lighting. I madea a simple sunset lighting scene by changing direction and lighting values in the directional light. Then when to lighting and rendernig and baked the scene.

Scene 2 - Real Time Lighting:
In this scene I played around with directional, point and spot lights. I adjusted their sizes, intensity, colors, shadow intensity and more to make them look different and play with the scene shadows differently. I was going for a museum type scene with moving and flickering lights around the scene. 

Scene 3 - Textured Materials:
In this scene I got different Unity textures and played around with the material settings to make different effects. For the planes I edite the tiling, for the two more transparent spheres I edited the transperancy and made different effects, for the glowing sphere I edited the tiling and emmission, and for the grass sphere I edited the normal map to make it more textured.

Scene 4 - Vertex Shader:
See "WobbleEffect" shader in Shaders folder. 
I wanted to play around with moving around the vertices of the shape so I created a glitch type effect with a pulsing effect as well. The shader displaces the vertices using a sin function and noise creating the glitch effect. Similarily I oscillate the amplitude of the mesh using a sin function as well, displacing the vertices ina pulse/heartbeat effect. I added transparency and emission for a cool effect. 

Scene 5 - Fragment Shader:
See "ThermalShader" shader in Shaders folder. 
For this one I am finding the position of the directional light in the scene and changing the colors position based on where the light is. Red it where light is facing and blue is where light is facing away from. There are colors in between as well for a gradient effect. I added a slight flickering effect as well for some movement.

Scene 5 - Post-Processing:
Created a post processing volume profile (can be found in Scenes>PostProcessing) and added bloom, chromatic aberration and color adjustments to make a cool looking scene.

Scene 7 - Creative Showcase:
For this final scene I created a nightime glowing forest scene. I used shaders to move vertices and pulse the glow of different objects such as the trees, fireflies, fog and mushrooms. I used a post processing volume to apply bloom,color adjustments, a vignette, chromatic abberation and lens disortion for the glow and the vibe. I used a spot light to create a light coming from the moon. 
