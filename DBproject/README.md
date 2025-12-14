# Project: Tournament Bracket  
# Author: Ikbol Allakhunov  

## Description  
This project is a relational database designed to store information about tournaments, participants, matches, and results.  
The database implements a multi-tournament system with support for rounds, participant registration, and match result recording.  
It is built with **PostgreSQL** and supports automatic ER diagram visualization in DBeaver or pgAdmin.  

## Database Structure  
| Table | Purpose |
|--------|----------|
| `tournaments` | List of all tournaments |
| `participants` | Participants (players or teams) |
| `tournament_participants` | Registration of participants in specific tournaments |
| `rounds` | Tournament rounds (stages) |
| `matches` | Matches between participants |
| `match_results` | Match results |

## Relationship Schema  
```
tournaments ───< rounds ───< matches ───< match_results  
      │                         │  
      └──< tournament_participants >── participants  
                                     │  
                                     └──< match_results
```
