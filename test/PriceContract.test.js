const { assert } = require('chai')

const PriceContract= artifacts.require("PriceContract")
require('chai')
    .use(require('chai-as-promised'))
    .should()


contract("PriceContract", (accounts)=>{
    let priceContract

    before(async ()=>{
        priceContract= await PriceContract.deployed();
    })

    describe('deployment', async ()=>{
        it('deployed successfully', async()=>{
            const address= priceContract.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address,null)
            assert.notEqual(address, undefined)
        })
    })

    describe('Eth/Usd value', async ()=>{
        it('updates the storeHash', async ()=>{
            await priceContract.storePrice()
            const result= await priceContract.storePrice()
            assert.isAbove(result, 0, "Value of eth/usd cannot be less than 1")
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })
    })

    // Other tests can be:
    //1. ARRAY IS NOT EMPTY AFTER FIRST StorePrice() call
    //2. AFTER DELETION THAT INDEX IS EMPTY.
    // etc.
})