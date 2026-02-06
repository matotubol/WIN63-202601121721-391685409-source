package com.sulake.habbo.catalog.navigation
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.incoming.catalog.class_2971;
   
   public interface class_1737
   {
      
      function dispose() : void;
      
      function get catalog() : IHabboCatalog;
      
      function buildCatalogIndex(param1:class_2971) : void;
      
      function showIndex() : void;
      
      function activateNode(param1:class_1917) : void;
      
      function loadFrontPage() : void;
      
      function get initialized() : Boolean;
      
      function getNodesByOfferId(param1:int, param2:Boolean = false) : Vector.<class_1917>;
      
      function getNodeByName(param1:String) : class_1917;
      
      function getOptionalNodeByName(param1:String) : class_1917;
      
      function getNodeById(param1:int, param2:class_1917 = null) : class_1917;
      
      function openPage(param1:String) : void;
      
      function openPageById(param1:int, param2:int) : void;
      
      function openPageByOfferId(param1:int) : void;
      
      function deactivateCurrentNode() : void;
      
      function filter(param1:String, param2:Array) : void;
      
      function get listTemplate() : class_1741;
      
      function getItemTemplate(param1:int) : class_1741;
      
      function get isDeepHierarchy() : Boolean;
   }
}

