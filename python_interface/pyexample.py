import NeuralProgrammingUint as NPU

# number of inputs
inputs = 3
# number of outputs
outputs = 3
# number of hidden layers
hlayers = 2
# number of nodes in each hidden layer
hlayer_ vals = [4, 4]
# specify size of training batch
tr_batch_size = 1000
# specify size of testing batch
tst_batch_size = 50

# establish connection with NPU
NPU.connect()

# initialize neural network
NPU.parameters(inputs, outputs, hlayers, hlayer_vals)

# read data from file
NPU.loadData("filename.txt")

# write all data to the NPU
NPU.writeAll()

# retrieve accuracy statistics from NPU
