School App är en cross-platform applikation utvecklad i Flutter med syftet att kombinera väderdata med
schemahantering från Firebase.
----------------------------------------------

Applikationen funktiolitet och arkitektur :
• Inkludera 3 olika UI Interaktiv Widgets , t.ex ElevatedButton , TextFormField, IconButton
• Firebase Realtime Database för schemalagring
• REST API-integration för väderdata
• SharedPreferences för lokal lagring av användarinställningar
• IP thjänst för platslokation
• navigering mellan 2 sidor med Navigator
• ha en custom appicon , inklusive favicon för webben.
• Loffie animation
• Fungera på både Android & webbläsare (t.ex: chrome/firefox/safari)
Nyckelfunktioner:
• Dynamisk hämtning av väder, sök efter väder
• Dynamisk hämtning av school schema

-----------------------------------------
Implementerade UI Interaktiva Widgets
Existerande Interaktiva Komponenter
TextField med IconButton: Sökfunktionalitet för städer med realtidsvalidering

ElevatedButton: Primär navigering till schemasidan

ListView: Scrollbar container för innehållspresentation

Navigation System: Programmatisk navigering mellan vyer

State Management: Dynamiskt UI-uppdatering genom setState()
------------------------------------------
Data Layer:

Firebase Realtime Database för schemalagring

REST API-integration för väderdata

SharedPreferences för lokal lagring av användarinställningar

Geolocation-tjänster för platsbaserade tjänster
