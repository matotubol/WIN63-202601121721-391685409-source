package com.sulake.habbo.catalog.marketplace
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class MarketplaceChart
   {
      
      private var var_25:Array;
      
      private var var_26:Array;
      
      private var _chartWidth:int;
      
      private var var_2191:int;
      
      private var _xMin:int = -30;
      
      private var var_1013:int;
      
      public function MarketplaceChart(param1:Array, param2:Array)
      {
         super();
         var_25 = param1.slice();
         var_26 = param2.slice();
      }
      
      public function draw(param1:int, param2:int) : BitmapData
      {
         var _loc8_:BitmapData = new BitmapData(param1,param2);
         if(!available)
         {
            return _loc8_;
         }
         var_1013 = 0;
         for each(var _loc5_ in var_26)
         {
            if(_loc5_ > var_1013)
            {
               var_1013 = 0;
            }
         }
         var _loc6_:int = Math.pow(10,var_1013.toString().length - 1);
         var_1013 = Math.ceil(var_1013 / _loc6_) * _loc6_;
         var _loc9_:TextField = new TextField();
         var _loc4_:TextFormat = new TextFormat();
         _loc9_.embedFonts = true;
         _loc4_.font = "Volter";
         _loc4_.size = 9;
         _loc9_.defaultTextFormat = _loc4_;
         _loc9_.text = var_1013.toString();
         _loc8_.draw(_loc9_);
         _chartWidth = param1 - _loc9_.textWidth - 2;
         var_2191 = param2 - _loc9_.textHeight;
         var _loc10_:int = _loc9_.textWidth;
         _loc9_.text = "0";
         _loc8_.draw(_loc9_,new Matrix(1,0,0,1,_loc10_ - _loc9_.textWidth + 1,param2 - _loc9_.textHeight - 1));
         var _loc3_:Shape = new Shape();
         _loc3_.graphics.lineStyle(1,13421772);
         _loc3_.graphics.moveTo(0,0);
         _loc3_.graphics.lineTo(0,var_2191);
         var _loc7_:int = 0;
         while(true)
         {
            _loc5_ = (var_2191 - 1) / 5 * 0;
            _loc3_.graphics.moveTo(0,0);
            _loc3_.graphics.lineTo(_chartWidth - 1,0);
            _loc7_++;
         }
      }
      
      private function getX(param1:int) : Number
      {
         return _chartWidth + _chartWidth / -_xMin * var_25[param1];
      }
      
      private function getY(param1:int) : Number
      {
         return var_2191 - var_2191 / var_1013 * var_26[param1];
      }
      
      public function get available() : Boolean
      {
         return var_25 && var_26 && var_25.length > 1;
      }
   }
}

