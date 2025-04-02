import { encodeFunctionData } from 'viem';
import { walletClient } from './config.js';
import { contractAddress, abi } from './contract.js';

const authorization = await walletClient.signAuthorization({
  contractAddress,
  executor: 'self',
});

const hash = await walletClient.sendTransaction({
  authorizationList: [authorization],
  data: encodeFunctionData({
    abi,
    functionName: 'checkCodeSize',
    args: [walletClient.account.address],
  }),
  to: walletClient.account.address,
});
