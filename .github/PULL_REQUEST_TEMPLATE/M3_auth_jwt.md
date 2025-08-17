# PR — M3: Auth (JWT)

## Summary
Add SimpleJWT; login/refresh endpoints; protect one endpoint; admin user mgmt.

## Linked Issue(s)
Closes #<id>

## Acceptance Criteria
- [ ] `/api/token/` & `/api/token/refresh/` working
- [ ] Protected endpoint returns 401 without token, 200 with valid token
- [ ] Tests cover auth & refresh flow
- [ ] Admin configured for user management
