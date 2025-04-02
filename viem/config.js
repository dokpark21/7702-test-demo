import { createWalletClient, http } from 'viem';
import { sepolia } from 'viem/chains';
import { privateKeyToAccount } from 'viem/accounts';

export const eoa =
  privateKeyToAccount();
  // private key

// self executing
export const walletClient = createWalletClient({
  account: eoa,
  chain: sepolia,
  transport:
    http(),
    // rpc-url
});
