module ibt::ibt {
    use sui::coin;
    use sui::transfer;
    use sui::tx_context;
    use sui::tx_context::TxContext;
    use std::option;

    /// One-Time Witness type (must be UPPERCASE and match module name: `ibt`)
    public struct IBT has drop {}

    /// Init runs once at publish time. Deployer receives TreasuryCap, so only deployer can mint/burn.
    fun init(otw: IBT, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<IBT>(
            otw,
            9,
            b"Intro Blockchain Token",
            b"IBT",
            b"IBT on Sui localnet",
            option::none(),
            ctx
        );

        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
        transfer::public_transfer(metadata, tx_context::sender(ctx));
    }

    /// Deployer-only mint (requires TreasuryCap<IBT>)
    public fun mint(
        cap: &mut coin::TreasuryCap<IBT>,
        to: address,
        amount: u64,
        ctx: &mut TxContext
    ) {
        let c = coin::mint(cap, amount, ctx);
        transfer::public_transfer(c, to);
    }

    /// Deployer-only burn (requires TreasuryCap<IBT>)
    public fun burn(cap: &mut coin::TreasuryCap<IBT>, c: coin::Coin<IBT>) {
        coin::burn(cap, c);
    }
}

