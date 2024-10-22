# Ragdoll Physics Prototype

This prototype demonstrates character movement and physics modeling based on ragdoll mechanics. It is specifically designed for game developers who want to explore physics-driven character motion and fine-tuning using GML code. The prototype showcases how a physics-based character can interact with its environment in a realistic way, making it a valuable learning resource for those interested in game development with GameMaker.

*Note: This project is a prototype. If you choose to use this code, it's recommended to optimize and adapt it to better suit your specific requirements. The code serves as a foundational example, but further customization may be necessary for production use.*

<div align="center">
    <img src="https://github.com/user-attachments/assets/a16e3aa4-dede-494e-aaf4-700979df9473" alt="intro">
</div>

# Contents

- [Introduction](#ragdoll-physics-prototype)
- [Features](#features)
- [Usage](#usage)
- [Installation](#installation)
- [License](#license)
  
# Features

- **Physics-Driven Movement**: The character's movements and interactions are based on physics calculations, providing realistic and dynamic behavior.
- **Ragdoll Mechanics**: Includes ragdoll elements that allow the character to respond naturally to collisions and forces.
- **Joint and Motor Control**: Configurable joint constraints and motorized movements enable precise control over limb articulation.
- **Customizable Settings**: Physics properties such as friction, damping, and restitution can be adjusted to fine-tune character behavior.
- **GML Implementation**: Written entirely in GameMaker Language (GML), making it suitable for GameMaker projects and easy to integrate.

<p align="center">
    <img src="https://github.com/user-attachments/assets/88c75a57-aec0-4ea9-adbe-bbd6873c8571" alt="drill" width="45%">
    <img src="https://github.com/user-attachments/assets/6e4c9d7c-f94f-49aa-9e08-acfe12fc7740" alt="swim" width="45%">
</p>

# Usage

This prototype is designed as a learning tool for exploring physics-driven character movement and ragdoll mechanics in GameMaker. It provides a robust foundation for integrating realistic character behavior into a game. While the current implementation offers a solid base, additional adjustments and improvements may be necessary for a fully polished experience.

<p align="center">
  <img src="https://github.com/user-attachments/assets/d9c1132e-7102-4594-bf89-6be7e41cc470" alt="214r3r-ezgif com-video-to-gif-converter">
</p>

# Installation

1. **Create a New Project in GameMaker**  
   Begin by opening GameMaker and creating a new project. Name your project according to your preferences. 

   <img width="158" alt="Screenshot 2024-10-22 at 9 47 18" src="https://github.com/user-attachments/assets/63ec39aa-992e-4484-ad45-3906f4c24a0c">

2. **Configure Room Physics**  
   Next, enable physics in the room settings. Set the gravity as shown in the image below:
   
   <img width="234" alt="Screenshot 2024-10-22 at 9 48 13" src="https://github.com/user-attachments/assets/dd12c426-94cf-461f-9dd9-23d46cc37655">

3. **Create the Necessary Objects**  
   Add the following objects to your project, as shown in the image below:
   
   <img width="229" alt="Screenshot 2024-10-22 at 9 52 25" src="https://github.com/user-attachments/assets/b07dcfd6-3ae0-4f99-b54b-edc90843003c">

   You can find the code for these objects in the GitHub repository.
   [Download the repository as a ZIP file](https://github.com/andytrix/RagdollPhysicsPrototype/archive/refs/heads/main.zip).

4. **Create Obj_Ground**  
   Create an object named `Obj_Ground` for testing purposes. 
   
   <img width="182" alt="Screenshot 2024-10-22 at 13 11 33" src="https://github.com/user-attachments/assets/41a606de-75eb-40e1-a07c-316578509a00">

   Set its physics properties as shown in the image below. Additionally, make sure to create a sprite and assign it to `Obj_Ground` so that you can modify its collision shape in the `Modify Collision Shape` section. Without a sprite, the object will not have a physical form.

   <img width="602" alt="Screenshot 2024-10-22 at 13 11 55" src="https://github.com/user-attachments/assets/bda73a5d-a618-4126-9ad0-d1b073a101ad">

5. **Add Objects to the Room**  
   Place `obj_Player` and `Obj_Ground` into `Room1` as shown in the image below:

   <img width="764" alt="Screenshot 2024-10-22 at 13 22 44" src="https://github.com/user-attachments/assets/29fa9ae8-4235-44af-8c67-af7b84797854">

6. **Event Structure Summary**  
   Below is the event structure for each object. The images provided show the events set up within each respective object.
   
   #### `obj_Player`
   <img width="145" alt="Screenshot 2024-10-22 at 10 20 15" src="https://github.com/user-attachments/assets/8974f587-3e0a-420a-a6ce-36d12052f72a">

   #### `obj_PlayerBody`
   <img width="155" alt="Screenshot 2024-10-22 at 10 20 34" src="https://github.com/user-attachments/assets/2f603ec1-1dbc-4dde-b294-0ba7456148a3">

   #### `obj_PlayerBody_2`
   <img width="107" alt="Screenshot 2024-10-22 at 10 20 49" src="https://github.com/user-attachments/assets/0b68ce7e-f6f1-48b7-9eae-f6e95107dfde">

   #### `obj_PlayerBodyLeg`
   <img width="155" alt="Screenshot 2024-10-22 at 10 20 34" src="https://github.com/user-attachments/assets/2f603ec1-1dbc-4dde-b294-0ba7456148a3">

7. **Completion**  
   Now that you have completed all the steps, you should have a functioning ragdoll physics character in your GameMaker project.

# License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute the code, as long as you give appropriate credit to "andytrix".
