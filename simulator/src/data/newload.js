import load from './load';
const staticCircuitData = {
    // Define your circuit data here
    // Example:
    name: "My Circuit",
    projectId: "123456",
    // Add more properties as needed
};

// Function to load circuits into the simulator using static data
function loadCircuitsIntoSimulator() {
    try {
        // Call the load function to load the static circuit data into the simulator
        load(staticCircuitData);

        console.log('Circuits loaded successfully into the simulator');
    } catch (error) {
        console.error('Error loading circuits into the simulator:', error.message);
    }
}

// Call the function to load circuits into the simulator when needed
loadCircuitsIntoSimulator();