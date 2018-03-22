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

# specify size of training and testing data
NPU.train_params(tr_batch_size, tst_batch_size)

# write all data to the NPU
NPU.writeAll()

# begin training
NPU.train()

# retrieve accuracy statistics from NPU
error = NPU.error()
print(error)

# run NPU with a new data point
ex_input = [0.25, 0.5, 0.75]
ex_output = NPU.run(example)
print(ex_output)
