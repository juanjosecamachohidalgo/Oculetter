//
//  GraficaViewController.swift
//  Oculetter
//
//  Copyright © 2019 Universidad de Almeria. All rights reserved.
//

import Foundation
import UIKit
import Charts
import CoreData
class GraficaViewController: UIViewController,ChartViewDelegate {
    
    
    
   
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var arrayLetras: [String] = []
    var arrayValores: [Double] = []
    let valores = ["F": 1.0, "B": 100.0, "W": 50.0, "D": 66.0, "A": 40.0]
    var data: [String:Double] = [:]
    var datosProcesados: [String:Double] = [:]
    var letras: [String] = []
    var arrayL: [String] = []
    var Valores: [Double] = []
    
    //DATOS REALES VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.noDataText = "You need to provide data for the chart."
        
        
        obtenerDatosBD()
        //cargarDatosADictionary(data)
        //crearDatos(datosProcesados)
        crearDatos(data)
        
        
        
        
    }
    //DATOS EJEMPLO VIEWDIDLOAD
    
    /**override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.noDataText = "You need to provide data for the chart."
        

        crearDatos(valores)
        setChart(arrayLetras, values: arrayValores)
        
        
    }**/

    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart."
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Aciertos")
        let chartData = BarChartData(xVals: arrayL, dataSet: chartDataSet)
        barChartView.data = chartData
        
        barChartView.descriptionText = ""
        
    }
    
    func crearDatos(datos: [String:Double]){
        let sortedDict = datos.sort { $0.1 > $1.1 }
        print(sortedDict)
        
        arrayLetras = sortedDict.map { return $0.0 }
        arrayValores = sortedDict.map { return $0.1 }
        
        if(arrayLetras.count > 5){
            
            var arrayV: [Double] = []
            for i in 0..<5 {
                    arrayL.append(arrayLetras[i])
                    arrayV.append(arrayValores[i])
                
            }
            setChart(arrayL, values: arrayV)
        
            
        }
        else{
             setChart(arrayLetras, values: arrayValores)
        }
      
       
        
    }
    func obtenerDatosBD(){
        
        var locations  = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Letter")
        
        do{
            locations =  try managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            print(locations)
            for location in locations {
                
                
                var v = 0.0
                let k = location.valueForKey("nombre") as! String
                let r = location.valueForKey("reconocida") as! Bool
                if(r == true){
                    v = 1.0
                }
                if(data.keys.contains(k)){
                    for(a,c) in data{
                        if(a == k){
                            
                           data.updateValue(c+1, forKey: k )
                            
                        }
                    }
                    
                }else{
                    data.updateValue(v, forKey: k )
                }
                
                
                
                
                
            }
        }catch{
            print("error")
        }
        
        
        
    }
    func cargarDatosADictionary(datos: [String:Double]){
        var letras:[String] = []
        letras.append("A")
        letras.append("B")
        letras.append("C")
        letras.append("D")
        letras.append("E")
        letras.append("F")
        letras.append("G")
        letras.append("H")
        letras.append("I")
        letras.append("J")
        letras.append("K")
        letras.append("L")
        letras.append("M")
        letras.append("N")
        letras.append("O")
        letras.append("P")
        letras.append("Q")
        letras.append("R")
        letras.append("S")
        letras.append("T")
        letras.append("U")
        letras.append("V")
        letras.append("W")
        letras.append("X")
        letras.append("Y")
        letras.append("Z")
        
        
        for var i = 0; i <= letras.count-1 ; i += 1 {
            var contadorTotal = 0.0
            var datosLetra: [String:Double] = [:]
            print(datos)
            for (k,v) in datos{
                var contadorLetra = 0.0;
                if(k == letras[i]){
                    contadorLetra+=v
                    contadorTotal += 1.0
                    //Si no actualiza el key ya existente, y lo añade a continuación, en datosProcesados, hay que añadir en vez de el valor primero, el último
                    datosLetra.updateValue(contadorLetra, forKey: letras[i])
                    print(datosLetra)
                }
                
            }
            let l = datosLetra.values.maxElement()!
            let percent = calcularPorcentaje(l,total: contadorTotal)
            datosProcesados.updateValue(percent, forKey: letras[i])
        }
        
        
        
    }
    func calcularPorcentaje(letra: Double, total: Double) -> Double{
        let calculo = letra*total/100
        return calculo
    }

    
        
}
