//
//  PortfolioDataService.swift
//  Crypto
//
//  Created by ebpearls on 8/4/2024.
//

import Foundation
import CoreData

class PortfolioDataService {
    
    let portfolioContainer : NSPersistentContainer;
    
    @Published var portfolioEntity : [PortfolioEntity] = []
    
    init() {
        self.portfolioContainer =  NSPersistentContainer(name: "PortfolioContainer")
        portfolioContainer.loadPersistentStores {print(($1)?.localizedDescription ?? "")}
        
        getPortfolio()
    }
    
    
    func updatePortfolio(_ coin : CoinModel, amount : Double) {
        
        guard let portfolioEntity = portfolioEntity.first(where: { $0.id == coin.id }) else {
            return add(coin, amount: amount)
        }
        
        if amount <= 0 {
            delete(portfolioEntity)
        }else{
            update(portfolioEntity, newAmount: amount)
        }
        
    }
    
    private func getPortfolio() {
        let request =  NSFetchRequest<PortfolioEntity>(entityName: "PortfolioEntity")
        do{
            portfolioEntity =  try portfolioContainer.viewContext.fetch(request)
        }catch (let error){
            print(error.localizedDescription)
        }
    }
    
    private func add (_ coin : CoinModel, amount : Double) {
        let portfolioEntity = PortfolioEntity(context: portfolioContainer.viewContext)
        portfolioEntity.id = coin.id
        portfolioEntity.quantity = amount
        applyChanegs()
    }
    
    private func update (_ entity : PortfolioEntity, newAmount : Double) {
        entity.quantity = newAmount
        applyChanegs()
    }
    
    private func delete (_ entity : PortfolioEntity) {
        portfolioContainer.viewContext.delete(entity)
        applyChanegs()
    }
    
    
    private func applyChanegs() {
        save()
        getPortfolio()
    }
    
    private func save() {
        do {
            try  portfolioContainer.viewContext.save()
        }
        catch(let error) {
            print(error.localizedDescription)
        }
    }
}
