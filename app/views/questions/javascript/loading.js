document.addEventListener("DOMContentLoaded", function() {
    const simulatorElement = document.getElementById("simulator");
    const circuitData = JSON.parse(simulatorElement.dataset.circuit);
  
    // Configure simulator with fetched data
    configureSimulator(circuitData);
  });
  
  // Function to configure simulator
  function configureSimulator(data) {
    // Extract relevant information from the data
    const circuitName = data.name;
    const nodes = data.allNodes || [];
  
    // Configure simulator components
    nodes.forEach(node => {
      // Process nodes and configure your simulator accordingly
      console.log(`Configuring node ${node.nodeId} - ${node.nodeName}`);
    });
  
    // Run simulation
    // Simulate the configured circuit with input values
    console.log(`Running simulation for circuit: ${circuitName}`);
  }
  