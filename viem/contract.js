export const contractAddress = // contract address;

export const abi = [
  {
    type: 'function',
    name: 'checkCodeSize',
    inputs: [
      {
        name: '_addr',
        type: 'address',
        internalType: 'address',
      },
    ],
    outputs: [
      {
        name: '',
        type: 'uint256',
        internalType: 'uint256',
      },
    ],
    stateMutability: 'view',
  },
];
