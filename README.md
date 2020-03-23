# omoponfhir-omopv5-stu3-conceptmapping-server

This Server has only ConceptMap/$translate operation part of FHIR.  
For example, the following REST GET translate RxNorm 311040 to NDFRT system.

GET REQUET:
-----------
> http://localhost:8080/fhir/ConceptMap/$translate?system=http://www.nlm.nih.gov/research/umls/rxnorm&code=311040&targetsystem=http://hl7.org/fhir/ndfrt

RESPONSE:
---------
```JSON
{
  "resourceType": "Parameters",
  "parameter": [
    {
      "name": "result",
      "valueBoolean": true
    },
    {
      "name": "match",
      "part": [
        {
          "name": "equivalence",
          "valueCode": "equivalent"
        },
        {
          "name": "concept",
          "valueCoding": {
            "system": "http://hl7.org/fhir/ndfrt",
            "code": "4014955",
            "display": "INSULIN,ASPART,HUMAN 100 UNT/ML INJ"
          }
        }
      ]
    }
  ]
}
```
